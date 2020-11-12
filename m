Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E322B081C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKLPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:06:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgKLPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:06:32 -0500
Received: from [192.168.1.155] ([77.2.56.136]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mwwm5-1kOB6I1LZL-00yRYU; Thu, 12 Nov 2020 16:06:17 +0100
Subject: Re: [PATCH] platform/x86: dell-privacy: Add support for new privacy
 driver
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20201103125542.8572-1-Perry_Yuan@Dell.com>
 <20201104014915.45tbmnrqvccbrd2k@srcf.ucam.org>
 <SJ0PR19MB4528E93631DA5FD8BE1D6E8D84E80@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <20201111072456.tkwdzuq2wa7zvbod@srcf.ucam.org>
 <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e8e06aca-c3f1-d833-c766-01f05dfa0f37@metux.net>
Date:   Thu, 12 Nov 2020 16:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636956DB58B0E4ECAD43549FAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9dO9kWhJK+Yiv5WXFGQ6CdJgiu7btiqPDtQvE3PtEsZFKMnKKgw
 G5371blyA1xBAviVZWATvXZu5XwGqiGHFM+vWs5XY3+elGTsqsAmWEHJOVTcOp3D9LwPNpw
 YEDkLj6K0BPhyRdyOcxjvU8Tn4G1+V1EaYaJMTms11izmyO+tPAcWquSQmdxHA2FoLhVIXo
 PhxgTEEAYVvHHYEoO2/og==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jASyvmm6cYU=:aiwJkp9gIZc0fNVu+KOCkU
 GC8gn4/yqG5nH3i8DDbjnj20hIaK71nnaIRUQgSOgh32zqxZlFsr9S2SVt5f/ouADG1RdHUar
 CI5a1v2cvalBLnZCUg7JbNfqBFNBr8Moua8oDOuPuyx3SEtcKjoYdX8+yn6X75CKqd0Bocb7Y
 CMpblCrbgQuMxwTZk68XAVs7hY0eKSXFFIe+1/+kdjUepCFdVcXLn0LR4IHJ6EgRT0CXYfF7N
 g2HKyye7ymZUbnyoGgDhFsG9AAW5yiO1QxoU+tKQmuaVKs0EgglXwmpStcaXbNI4FsLSFFIfy
 j/t+9OSMpAlrb1fr+NcnGHO6lkADlOSngjHrUpkqK13D+AEsUzoBI/EaMTHmT8sY6o5Cb/oyx
 UoTLXYTfhCVssH9j64HyRHQ2J9eFgsL20HHIbH/2tRywJvz4gNYgLbSxN6LR8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 15:30, Limonciello, Mario wrote:

Hi,

> Pressing the mute key activates a time delayed circuit to physically cut
> off the mute.  The LED is in the same circuit, so it reflects the true
> state of the HW mute.  The reason for the EC "ack" is so that software
> can first invoke a SW mute before the HW circuit is cut off.  Without SW
> cutting this off first does not affect the time delayed muting or status
> of the LED but there is a possibility of a "popping" noise leading to a
> poor user experience.

how long is that timeout ?

> Exposing as an LED device allows the codec drivers notification path to
> EC ACK to work.

Which driver exactly ? Who's gonna access this LED ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
