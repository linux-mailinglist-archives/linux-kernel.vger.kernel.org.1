Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3906629BB72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1806217AbgJ0QGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:06:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1802375AbgJ0PrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8814AFE8;
        Tue, 27 Oct 2020 15:46:59 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:46:58 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201027154658.GG22179@suse.de>
References: <20201025004158.GA767345@rani.riverdale.lan>
 <20201027124007.xkkseswwgerlzlsl@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027124007.xkkseswwgerlzlsl@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:40:07PM +0300, Kirill A. Shutemov wrote:
> BTW, what happens if we underestimate BOOT_PGT_SIZE? Do we overwrite
> something?

The boot code will print an error and stop the machine when allocating a
page-table page fails.

I also think that bumping BOOT_PGT_SIZE up to have more pages available
is a good short-term solution. Recycling pages will also need to take
page encryption attributes into account, as for SEV-ES the GHCB page
needs to be mapped unencrypted.

Another option to safe some memory is to make use of GB pages in the
decompression code. Machines where the current BOOT_PGT_SIZE is too
small will likely support GB pages too.

Regards,

	Joerg
