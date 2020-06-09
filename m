Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E231F3A16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgFILuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 07:50:00 -0400
Received: from verein.lst.de ([213.95.11.211]:42075 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFILt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:49:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40B2D68AFE; Tue,  9 Jun 2020 13:49:55 +0200 (CEST)
Date:   Tue, 9 Jun 2020 13:49:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Rientjes <rientjes@google.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200609114955.GA2027@lst.de>
References: <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de> <20200609084305.GA21671@lst.de> <s5hlfkwip1h.wl-tiwai@suse.de> <20200609091727.GA23814@lst.de> <s5hh7vkio0n.wl-tiwai@suse.de> <20200609113123.GA547@lst.de> <s5h3674ii49.wl-tiwai@suse.de> <20200609114059.GA1228@lst.de> <s5hzh9ch38h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzh9ch38h.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:45:34PM +0200, Takashi Iwai wrote:
> Yes, for the sound stuff, something below should make things working.
> But it means that we'll lose the SG-buffer allocation and the
> allocation of large buffers might fail on some machines.

We crossed lines there.  In general due to better memory compaction and
CMA we have better chances to get larger contiguous allocations these
days, so this might not be too much of an issue in practice.
