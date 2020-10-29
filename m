Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5429EF52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgJ2PLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgJ2PLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:11:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA070B909;
        Thu, 29 Oct 2020 15:11:45 +0000 (UTC)
Date:   Thu, 29 Oct 2020 16:11:44 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: False positive from checkscript: git git://...
Message-ID: <20201029161144.3c7a4fb1@endymion>
In-Reply-To: <24f8766403f881d4f56a9b721f29b6ee5d1173e2.camel@perches.com>
References: <20201029143205.197ff58f@endymion>
        <24f8766403f881d4f56a9b721f29b6ee5d1173e2.camel@perches.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 07:55:25 -0700, Joe Perches wrote:
> On Thu, 2020-10-29 at 14:32 +0100, Jean Delvare wrote:
> > WARNING: Possible repeated word: 'git'
> > #20: FILE: MAINTAINERS:5289:
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next
> > 
> > Obviously that's going to happen a lot as this is actually the proper
> > way to list a git tree in that file. Could you please add an exception
> > for that case?
> 
> Already done in -next

Perfect, thank you very much.

-- 
Jean Delvare
SUSE L3 Support
