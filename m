Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9D28CA84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbgJMIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390190AbgJMIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:51:40 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FFC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:51:40 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4C9Tml6Zp0zlkxyN;
        Tue, 13 Oct 2020 10:51:35 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4C9Tmk5Vd6zlh8WW;
        Tue, 13 Oct 2020 10:51:34 +0200 (CEST)
Subject: Re: [PATCH v1] dm verity: Add support for signature verification with
 2nd keyring
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201002071802.535023-1-mic@digikod.net>
 <bda2ffd7-3b7c-33a4-667f-a3435e112fc1@digikod.net>
 <20201012235502.GA36149@linux.intel.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <1b344a3c-2671-3b1a-3c6b-f3b28e819bc5@digikod.net>
Date:   Tue, 13 Oct 2020 10:51:34 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201012235502.GA36149@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/10/2020 01:55, Jarkko Sakkinen wrote:
> On Fri, Oct 09, 2020 at 11:50:03AM +0200, Micka�l Sala�n wrote:
>> Hi,
>>
>> What do you think about this patch?
>>
>> Regards,
>>  Micka�l
>>
>> On 02/10/2020 09:18, Micka�l Sala�n wrote:
>>> From: Micka�l Sala�n <mic@linux.microsoft.com>
>>>
>>> Add a new DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING configuration
>>> to enable dm-verity signatures to be verified against the secondary
>>> trusted keyring.  This allows certificate updates without kernel update
>>> and reboot, aligning with module and kernel (kexec) signature
>>> verifications.
> 
> I'd prefer a bit more verbose phrasing, not least because I have never
> really even peeked at dm-verity, but it is also a good practice.
> 
> You have the middle part of the story missing - explaining the semantics
> of how the feature leads to the aimed solution.

OK, what about:

Add a new configuration DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
to enable dm-verity signatures to be verified against the secondary
trusted keyring. Instead of relying on the builtin trusted keyring (with
hard-coded certificates), the second trusted keyring can include
certificate authorities from the builtin trusted keyring and child
certificates loaded at run time. Using the secondary trusted keyring
enables to use dm-verity disks (e.g. loop devices) signed by keys which
did not exist at kernel build time, leveraging the certificate chain of
trust model. In practice, this allows to update certificates without
kernel update and reboot, aligning with module and kernel (kexec)
signature verification which already use the secondary trusted keyring.
