Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3136F283C98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgJEQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:34:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgJEQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:34:19 -0400
Received: from zn.tnic (p200300ec2f07d500f39533324043f5fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:f395:3332:4043:f5fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2B0D1EC02FC;
        Mon,  5 Oct 2020 18:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601915658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=34oJRrVot99MQyvWDKFEdCK+jBkfjNgeQbuykoTWHrg=;
        b=NQhnvVD+VjEasGQCMB9YP3JOKR1X9x8U0TpNU+qKBJ3QWSh7seBzDcjDW4qIlbCGErdfMH
        pPdSBm42YjOe3IfBGw06h0iVnvSS+ZY2dieTiGahyQ/8e/8OmsWAwjfqKjkcffeeVzf+mP
        99ixgR2sApNlX1v29WZ3ciEMIsYuGH8=
Date:   Mon, 5 Oct 2020 18:34:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/mce: Add _ASM_EXTABLE_CPY for copy user access
Message-ID: <20201005163414.GG21151@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232611.15355-4-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:07PM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> _ASM_EXTABLE_UA is a general exception entry to record the exception fixup
> for all exception spots between kernel and user space access.
> 
> To enable recovery from machine checks while coping data from user
> addresses we need to be able to distinguish the places that are

Who's "we"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
