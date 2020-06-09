Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476E01F3A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgFILrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 07:47:37 -0400
Received: from verein.lst.de ([213.95.11.211]:42054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgFILrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:47:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5858D68AFE; Tue,  9 Jun 2020 13:47:33 +0200 (CEST)
Date:   Tue, 9 Jun 2020 13:47:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Christoph Hellwig <hch@lst.de>, alsa-devel@alsa-project.org,
        bp@alien8.de, hch@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        rientjes@google.com, tglx@linutronix.de, tiwai@suse.com,
        x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200609114733.GA1621@lst.de>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591624340.z01ejtod28.none@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex, can you try this patch?

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index d4554f376160a9..10b06e575a7fc5 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -192,6 +192,6 @@ config SND_VMASTER
 
 config SND_DMA_SGBUF
 	def_bool y
-	depends on X86
+	depends on BROKEN
 
 source "sound/core/seq/Kconfig"
