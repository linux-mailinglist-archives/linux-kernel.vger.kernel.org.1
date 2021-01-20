Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212842FDCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbhATV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:27:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:36874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbhATUyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:54:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71DB6ABDA;
        Wed, 20 Jan 2021 20:53:54 +0000 (UTC)
Date:   Wed, 20 Jan 2021 21:53:54 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/21] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Message-ID: <20210120205354.GE3467@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-3-chang.seok.bae@intel.com>
 <20210115125048.GB11337@zn.tnic>
 <F06B741E-25C8-4777-9576-3684FF649F1E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F06B741E-25C8-4777-9576-3684FF649F1E@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:50:52PM +0000, Bae, Chang Seok wrote:
> I will add a sentence like this if looks fine:
> 
> "The copy functions used to have ‘xstate' in the name as they took a struct
> xregs_state * pointer."

What for?

I was just pointing out what the naming logic was and that you're
changing that...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
