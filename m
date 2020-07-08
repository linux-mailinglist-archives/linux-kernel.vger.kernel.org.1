Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90683217FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgGHGxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 02:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgGHGxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:53:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588792075B;
        Wed,  8 Jul 2020 06:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594191214;
        bh=g9ZlohxdxkjqpTSIdab6cJipB+jvPoyU/B+zybZjQug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZMg1ldP1BXdzQiHMFkXu7aHxwTh64Vlhyckb9kaTg+GWWZzMNEut8mTQb8xJ+Y4D
         N6v87HtjIX4uGta6CD2crc/ju2GwnO835wcPKSVZaV67/yxL6pytZe0r1v5nIf5b3+
         GDOWbSJYBqXmNDU02c6mR1J92fhfjTPWRzjOnU9Q=
Date:   Wed, 8 Jul 2020 08:53:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/13] misc: rtsx: Check the return value of
 pcie_capability_read_*()
Message-ID: <20200708065330.GA348669@kroah.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
 <20200707220324.8425-3-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707220324.8425-3-refactormyself@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:03:13AM +0200, Saheed Olayemi Bolarinwa wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> On failure pcie_capability_read_dword() sets it's last parameter, val
> to 0. In which case (val & PCI_EXP_DEVCTL2_LTR_EN) evaluates to 0.
> However, with Patch 13/13, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x).
> 
> This bug can be avoided without changing the function's behaviour if the
> return value of pcie_capability_read_word is checked to confirm success.
> 
> Check the return value of pcie_capability_read_word() to ensure success.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
