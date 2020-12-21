Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E832DFEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLURQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:16:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32789 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgLURQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:16:54 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krOn5-00031j-Mr
        for linux-kernel@vger.kernel.org; Mon, 21 Dec 2020 17:16:11 +0000
Received: by mail-lf1-f72.google.com with SMTP id i7so11566430lfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 09:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Pz4SBTDx6BMkbLDQ5nrfRYm9x7WmPr6bGZI10+5Wso=;
        b=uICQQM6g3fIWJ4fcmcOloNRDFHLdu2SvKZ1rHiuKWZIEoFSZRv84rAxxvVVdHxOwG/
         3QeHNjd8BildOZeyB7OLgVrjDNdaYL3WCECm8J+LnGGuVkqsNKihdaPw/912cYqdQpCF
         g4PwPb933wkFMTmzfpNUIXWNxz7u3Rpe/XOCA7MtuHDf0b65CN3G1vUwtEvCAlMyNyHD
         trZmDMekNqK6UudfrKUHrECJqUsvvnIoLOIY4PmfGyiVnuxSbza4sMcqndE/9d+K8O9B
         pIc1sB+3Uebh8Ofmg62ohnpBnSbO83MgdzOYDd+Ia54f10d+sxEYkRWnR3oRfPi89vIV
         nosg==
X-Gm-Message-State: AOAM530Dl8KqDdXtHMxIVWaI8njUV5a5f2WFSWL1mjnsdUupppuJp2Pc
        GI8Zd8NFu+BVNF+G407R9ALmgJZRdi2NsAF2zUFgVPevd+WhuuOzLdMO12nAoXEiaF7/OUSWAyt
        jQZ8APk0Ce9u1BUqexNuH0NnvOZUxlR9r+Tn659aMBU1YgvLLFYuS/KOvZw==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr1574952ljo.402.1608570971159;
        Mon, 21 Dec 2020 09:16:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2YXycweLB9saylOYpQELQXyDWheqBfUKEeeBhg9fBTp5dxHBt0XV6PKI9T7tz8LDvPKU6uC6XcVCTDVBIws8=
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr1574936ljo.402.1608570970912;
 Mon, 21 Dec 2020 09:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de> <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <s5hft3zf6mi.wl-tiwai@suse.de>
In-Reply-To: <s5hft3zf6mi.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Dec 2020 01:15:59 +0800
Message-ID: <CAAd53p7TOBwee6dfY8uY=2P6wGJ9Uf551LVp95jLwz7SA9PWFA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:47 AM Takashi Iwai <tiwai@suse.de> wrote:
[snip]
> But what happens if you plug the HDMI cable later and want to use the
> HDMI audio?  It won't work with your fix, right?

No it won't.
It's possible to fix from nouveau, but it's at the mercy of Nvidia to
fix their proprietary driver, which many users use.

Kai-Heng

>
>
> Takashi
