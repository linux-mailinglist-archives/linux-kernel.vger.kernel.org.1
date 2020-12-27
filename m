Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E609E2E325A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgL0SNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 13:13:24 -0500
Received: from mail1.perex.cz ([77.48.224.245]:33066 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgL0SNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 13:13:22 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 13:13:22 EST
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CC6E2A0042;
        Sun, 27 Dec 2020 19:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CC6E2A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1609092218; bh=R6E0WUyd+HzPTBrB5WL2D70BQXuqhUQ9I4IJCZL5Yg8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sxMzLrznPgvhLj61Ut3Spe3reCebG+bVP01QFjYEI+A5+5GFlP0e1N/PJU2Y4+LXm
         ZpMlxrDTRhOlPnzXQmbVAezr+63Wydkw67Iw700DEw0aF5Wpb+tf/4Blpfjnfg5l/x
         DMis0Oj78zn0A8SGd6HMB9Ek6cMC4FzzfACGMTJA=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Sun, 27 Dec 2020 19:03:28 +0100 (CET)
Subject: Re: [PATCH] ASoC: amd:Replacing MSI with Legacy IRQ model
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <9f1df5a9-f2ab-33da-3111-c01db88912b4@perex.cz>
Date:   Sun, 27 Dec 2020 19:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 22. 12. 20 v 12:59 Ravulapati Vishnu vardhan rao napsal(a):
> When we try to play and capture simultaneously we see that
> interrupts are genrated but our handler is not being acknowledged,
> After investigating further more in detail on this issue we found
> that IRQ delivery via MSI from the ACP IP is unreliable and so sometimes
> interrupt generated will not be acknowledged so MSI model shouldn't be used
> and using legacy IRQs will resolve interrupt handling issue.

What is the real culprit? It's hw bug? If not, it would be better to fix the
PCI code or the irq handler.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
