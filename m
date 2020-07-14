Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336F21E868
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGNGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 02:40:07 -0400
Received: from verein.lst.de ([213.95.11.211]:52882 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgGNGkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:40:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA82668CEC; Tue, 14 Jul 2020 08:40:04 +0200 (CEST)
Date:   Tue, 14 Jul 2020 08:40:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] X32 syscall cleanups
Message-ID: <20200714064004.GA32655@lst.de>
References: <20200616142315.375918-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616142315.375918-1-brgerst@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:23:13AM -0400, Brian Gerst wrote:
> Christoph Hellwig uncovered an issue with how we currently handle X32
> syscalls.  Currently, we can only use COMPAT_SYS_DEFINEx() for X32
> specific syscalls.  These changes remove that restriction and allow
> native syscalls.

Did this go anywhere?
