Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F382675C5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgIKWSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:18:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35752 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgIKWSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:18:07 -0400
Received: from nazgul.tnic (p200300ec2f1622003e970efffe6befe7.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:2200:3e97:eff:fe6b:efe7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87A0D1EC04F2;
        Sat, 12 Sep 2020 00:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599862686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=azv63SsLHwVubmYi/qpW9QYZuhwgDhlzJQsV4iO6l+A=;
        b=lmQdlljaqwuwLpaVQ+ICssNtMEsKduuaiLqyQDNyb9VwmN3P6WXQ9sOn0cjA5P27V/Gzk0
        F7UavlnAPvTEXLWexoX1cPeyn3GnQO9PZrE3sH22NgrYQxOG3pqwKNa3sTw1S+CZ8vOeGG
        P7+mETUE7Zfd2ZsFuMWWVik027sFXPs=
Date:   Sat, 12 Sep 2020 00:17:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200911221759.GA2869@nazgul.tnic>
References: <20200911195312.GA4110@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911195312.GA4110@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:53:12PM +0200, Borislav Petkov wrote:
> Now, looking at that patch:
> 
>   5795eb443060 ("scsi: sd_zbc: emulate ZONE_APPEND commands")
> 
> yeah, that doesn't revert cleanly. But it talks about zoned-something
> devices and that rings a bell because you guys broke my zoned device
> once already:

Ok, so Johannes and I poked a bit on IRC and here it is:

# CONFIG_BLK_DEV_ZONED is not set.

Enabling it, fixes the issue.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
