Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1C2871D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgJHJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:48:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJHJsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAACFADC1;
        Thu,  8 Oct 2020 09:48:37 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:48:36 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/boot/64: Explicitly map boot_params and command
 line
Message-ID: <20201008094836.GH3209@suse.de>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007195351.776555-5-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:53:50PM -0400, Arvind Sankar wrote:
> This is fragile, as boot_params and the command line mappings are
> required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
> disabled, a QEMU/OVMF boot never accesses the command line in the
> decompressor stub, and so it never gets mapped. The main kernel accesses
> it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
> crash.

Looked again, and I think that is wrong for boot_params, which are
touched unconditionally at the beginning of extract_kernel().

For the cmdline you are right, but one of CONFIG_ACPI,
CONFIG_RANDOMIZE_BASE, CONFIG_X86_5LEVEL or CONFIG_EARLY_PRINTK is
sufficient to have it touched during this boot stage.

Regards,

	Joerg

