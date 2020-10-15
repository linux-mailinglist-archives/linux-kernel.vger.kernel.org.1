Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D673E28EFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgJOJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgJOJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:53:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E0C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 02:53:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed200d49a97be428f152e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:d49a:97be:428f:152e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C37851EC026F;
        Thu, 15 Oct 2020 11:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602755600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=zScQ/j+2OTwc/ut3awEXHwVgWcoQxJcuLo2EoD8VuDA=;
        b=EHrPOK5i6017jUEyRdFuBNuVXI2J9G8ffOR5uQHif+W/kI6lu7U6WQW7LjECCgFE6rqNlZ
        630DQv0QES+6DoZw4XB8oudaMv88jeILIM6TUDtShL0DN5x4Wc57fY7l+vSrH4blciY2oQ
        VInEmkCiJGee1wWOn9zkQ/ivnZfHDWY=
Date:   Thu, 15 Oct 2020 11:53:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: DPTF_POWER and DPTF_PCH_FIVR
Message-ID: <20201015095311.GA11838@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dudes,

what are those new symbols in Kconfig and why do they wanna get enabled
on my box when doing oldconfig? Depends on X86? Really, that widespread?

The help text doesn't say why do I need this...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
