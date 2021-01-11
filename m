Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636E52F0BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAKE3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:29:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAKE3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:29:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60140AC95;
        Mon, 11 Jan 2021 04:29:03 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] usb/gadget: f_midi: Replace tasklet with work
Date:   Sun, 10 Jan 2021 20:28:55 -0800
Message-Id: <20210111042855.73289-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a tasklet is used to transmit input substream buffer
data. However, tasklets have long been deprecated as being too
heavy on the system by running in irq context - and this is not
a performance critical path. If a higher priority process wants
to run, it must wait for the tasklet to finish before doing so.

Deferring work to a workqueue and executing in process context
should be fine considering the callback already does
f_midi_do_transmit() under the transmit_lock and thus changes in
semantics are ok regarding concurrency - tasklets being serialized
against itself.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/gadget/function/f_midi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 8fff995b8dd5..71a1a26e85c7 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -87,7 +87,7 @@ struct f_midi {
 	struct snd_rawmidi_substream *out_substream[MAX_PORTS];
 
 	unsigned long		out_triggered;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	unsigned int in_ports;
 	unsigned int out_ports;
 	int index;
@@ -698,9 +698,11 @@ static void f_midi_transmit(struct f_midi *midi)
 	f_midi_drop_out_substreams(midi);
 }
 
-static void f_midi_in_tasklet(struct tasklet_struct *t)
+static void f_midi_in_work(struct work_struct *work)
 {
-	struct f_midi *midi = from_tasklet(midi, t, tasklet);
+	struct f_midi *midi;
+
+	midi = container_of(work, struct f_midi, work);
 	f_midi_transmit(midi);
 }
 
@@ -737,7 +739,7 @@ static void f_midi_in_trigger(struct snd_rawmidi_substream *substream, int up)
 	VDBG(midi, "%s() %d\n", __func__, up);
 	midi->in_ports_array[substream->number].active = up;
 	if (up)
-		tasklet_hi_schedule(&midi->tasklet);
+		queue_work(system_highpri_wq, &midi->work);
 }
 
 static int f_midi_out_open(struct snd_rawmidi_substream *substream)
@@ -875,7 +877,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
 
 	midi->gadget = cdev->gadget;
-	tasklet_setup(&midi->tasklet, f_midi_in_tasklet);
+	INIT_WORK(&midi->work, f_midi_in_work);
 	status = f_midi_register_card(midi);
 	if (status < 0)
 		goto fail_register;
-- 
2.26.2

