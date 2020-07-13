Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85056219E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGIKnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 06:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:43:32 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446C5206DF;
        Thu,  9 Jul 2020 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594291412;
        bh=uNc6urMDYEeEmMvXXpMgqHV9kij6NIXUjNyMzhu4DjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mD0T2ixnSRoHqc276cedOlp1oDHfFgItmqMtMtNB4t/i1mNMP6ECXXeid4oEHpflB
         AFwgNVFNK4ZjKvkShtfvLrWyCtuyEpRkydKG9AAPBiKURxlZFo+J7mPaCGPsq43dHU
         v/xPItLyiyzd15qwrS1g6k51T/zMmWvqLpyYwRBc=
Date:   Thu, 9 Jul 2020 12:43:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Tibor Raschko <tibrasch@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, skhan@linuxfoundation.org
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200709124327.369781a0@coco.lan>
In-Reply-To: <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
        <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 7 Jul 2020 01:58:21 +0200
Tibor Raschko <tibrasch@gmail.com> escreveu:

> > Allowlist/denylist terms are intuitive and action based which have a
> > globally uniform meaning.  
> 
> Nobody has a problem understanding "blacklist" and "whitelist". These
> are universally understood words even outside of computing. Claiming
> that we need clearer alternatives is smoke and mirrors.

Actually, as a non-native English speaker, the first time I saw 
"<color>list", I had to do some research in order to understand what it
means :-)

That reminds me: what about "graylist"?

For coherency, if "blacklist/whitelist" won't be used anymore, an
alternative to graylist should also be provided.

Right now, it seems that only ACPI uses it:

	$ git grep -i graylist
	drivers/clocksource/acpi_pm.c:static void acpi_pm_check_graylist(struct pci_dev *dev)
	drivers/clocksource/acpi_pm.c:                  acpi_pm_check_graylist);
	drivers/clocksource/acpi_pm.c:                  acpi_pm_check_graylist);

Thanks,
Mauro
