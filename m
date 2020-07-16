Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02240221B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 06:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgGPEyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 00:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPEyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:54:06 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:54:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6hjh1m8Dz9sR4;
        Thu, 16 Jul 2020 14:54:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594875240;
        bh=FmAkXsd5ylVmoGslmFobuHuO65vIrkIORrej0EwX2ts=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Q+fZUiVGUkVTM4eSFCMtRkFtxovdTo6nBtySqfDlb2q7ySoyuEWGLA49Ses8+LwNR
         qFckoQe3HjNIeOH2Up5nOdYzMZYqnjsk/FuCP+ohYJWUX/P3q43aAyVpEZzOmOM7a4
         RpYIb9Flr0ucpju+Xv17yhKosh8FdDoW9+qB8oByVMEjSufhJpXvc/gQOV2fzukiMb
         NiqsBike/HalTrjb42Wlr3chaRn7SEt8m2HGAQaR0vk9475WQ2wK7sL1EtrQm9i/7y
         fNT5fwDvdfoYGbT56wKLSb6ats077QovgkrWuhmvrKLdS57csz/P7LmBneL1md1yWR
         VuWDQ7hY0B9ug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@ozlabs.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <87v9iothc1.fsf@dja-thinkpad.axtens.net>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com> <87v9iothc1.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 16 Jul 2020 14:53:51 +1000
Message-ID: <87sgdst600.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Hi Nayna,
>
> Looks good to me.
>
> Sorry for not noticing this before, but I think
>> +#include <asm/machdep.h>

> is now superfluous (I think it's leftover from the machine_is
> version?). Maybe mpe will take pity on you and remove it when he picks
> up your patch.

Yeah I did that.

cheers
