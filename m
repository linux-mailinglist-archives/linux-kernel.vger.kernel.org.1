Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED52E3E54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503933AbgL1O06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503869AbgL1O0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:26:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A922206D4;
        Mon, 28 Dec 2020 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609165571;
        bh=szQs4ZqUCDQKYF2cv1WOcuBpGMFzvkTRpW1YLoJOZkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIFCE8YnS0pdrzpGC7XwW5UinC1PoPbhRNYhw1MDWv2Os2sxvuB8UkIya2ukZOa8w
         AADYs0eTwQR8IjQ2klD7CbQsuYV50YmF3PstbtbJSRmNeif0bINrW7LWYIGRHysc9T
         gVdmEbZwg8AF+Fwf+nF8VEUXwssdvMt4Lx9ep7bQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 548/717] ALSA: usb-audio: Disable sample read check if firmware doesnt give back
Date:   Mon, 28 Dec 2020 13:49:06 +0100
Message-Id: <20201228125047.195811381@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228125020.963311703@linuxfoundation.org>
References: <20201228125020.963311703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 9df28edce7c6ab38050235f6f8b43dd7ccd01b6d upstream.

Some buggy firmware don't give the current sample rate but leaves
zero.  Handle this case more gracefully without warning but just skip
the current rate verification from the next time.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20201218145858.2357-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/clock.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -531,6 +531,12 @@ static int set_sample_rate_v1(struct snd
 	}
 
 	crate = data[0] | (data[1] << 8) | (data[2] << 16);
+	if (!crate) {
+		dev_info(&dev->dev, "failed to read current rate; disabling the check\n");
+		chip->sample_rate_read_error = 3; /* three strikes, see above */
+		return 0;
+	}
+
 	if (crate != rate) {
 		dev_warn(&dev->dev, "current rate %d is different from the runtime rate %d\n", crate, rate);
 		// runtime->rate = crate;


