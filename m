Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0725A1ADFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDQOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgDQOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:18:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79477C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:18:49 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DA80060CD7BB5EE54F574.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a800:60cd:7bb5:ee54:f574])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 565871EC0D39;
        Fri, 17 Apr 2020 16:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587133125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rgZoIatcm+Gu5PJYpw6PupcUwD8Wv3dPWUib9QMaXkE=;
        b=fSZIHi8P6Gu/jO0T/UWsYJT31Py9KU7wuZKdX0WfmxZZ7SI2P2rvFDrjoUFx7plvquMHve
        ntkLicJWhCxum9DtMFUk/mHA+lSSGW86+ftAQ9KCJfzNtzOmVBcbCVbH9PY5JlqNIhswWO
        pb4eRy9b4UitaL9/0j4OqeHykpiBQlE=
Date:   Fri, 17 Apr 2020 16:18:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
Subject: Re: [PATCH v3] x86/resctrl: Preserve CDP enable over cpuhp
Message-ID: <20200417141841.GD7322@zn.tnic>
References: <20200221162105.154163-1-james.morse@arm.com>
 <8d84868f-4045-8d69-ed45-d0f0629ba25c@intel.com>
 <a411323a-2439-5d30-2106-2e3598e9a8c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a411323a-2439-5d30-2106-2e3598e9a8c7@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:57:34AM -0700, Reinette Chatre wrote:
> Hi Thomas and Borislav,
> 
> Could you please consider this patch for inclusion as a fix for v5.7?

Do you mean by that that I should add

Cc: <stable@vger.kernel.org>

so that it goes to stable?

The commit in Fixes: is from 4.10-ish times...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
