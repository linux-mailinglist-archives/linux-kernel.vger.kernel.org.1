Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB82CEEBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgLDNYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:24:08 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39193 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbgLDNYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:24:08 -0500
Received: from [192.168.0.2] (ip5f5af1d8.dynamic.kabel-deutschland.de [95.90.241.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1065B2064784C;
        Fri,  4 Dec 2020 14:23:24 +0100 (CET)
Subject: Re: [SPECIFICATION RFC] The firmware and bootloader log specification
To:     Wim Vervoorn <wvervoorn@eltan.com>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Cc:     coreboot@coreboot.org, LKML <linux-kernel@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org,
        trenchboot-devel@googlegroups.com,
        U-Boot Mailing List <u-boot@lists.denx.de>, x86@kernel.org,
        xen-devel@lists.xenproject.org, alecb@umass.edu,
        alexander.burmashev@oracle.com, allen.cryptic@gmail.com,
        andrew.cooper3@citrix.com, ard.biesheuvel@linaro.org,
        "btrotter@gmail.com" <btrotter@gmail.com>,
        dpsmith@apertussolutions.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, hpa@zytor.com, hun@n-dimensional.de,
        javierm@redhat.com, joao.m.martins@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@intel.com, luto@amacapital.net,
        michal.zygowski@3mdeb.com, Matthew Garrett <mjg59@google.com>,
        mtottenh@akamai.com,
        Vladimir 'phcoder' Serbinenko <phcoder@gmail.com>,
        piotr.krol@3mdeb.com, pjones@redhat.com, roger.pau@citrix.com,
        ross.philipson@oracle.com, tyhicks@linux.microsoft.com,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
 <CAODwPW9dxvMfXY=92pJNGazgYqcynAk72EkzOcmF7JZXhHTwSQ@mail.gmail.com>
 <6c1e79be210549949c30253a6cfcafc1@Eltsrv03.Eltan.local>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <9b614471-0395-88a5-1347-66417797e39d@molgen.mpg.de>
Date:   Fri, 4 Dec 2020 14:23:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6c1e79be210549949c30253a6cfcafc1@Eltsrv03.Eltan.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Wim, dear Daniel,


First, thank you for including all parties in the discussion.
Am 04.12.20 um 13:52 schrieb Wim Vervoorn:

> I agree with you. Using an existing standard is better than inventing
> a new one in this case. I think using the coreboot logging is a good
> idea as there is indeed a lot of support already available and it is
> lightweight and simple.
In my opinion coreboot’s format is lacking, that it does not record the 
timestamp, and the log level is not stored as metadata, but (in 
coreboot) only used to decide if to print the message or not.

I agree with you, that an existing standard should be used, and in my 
opinion it’s Linux message format. That is most widely supported, and 
existing tools could then also work with pre-Linux messages.

Sean Hudson from Mentor Graphics presented that idea at Embedded Linux 
Conference Europe 2016 [1]. No idea, if anything came out of that 
effort. (Unfortunately, I couldn’t find an email. Does somebody have 
contacts at Mentor to find out, how to reach him?)


Kind regards,

Paul


[1]: 
http://events17.linuxfoundation.org/sites/events/files/slides/2016-10-12%20-%20ELCE%20-%20Shared%20Logging%20-%20Part%20Deux.pdf
