Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAE1AB610
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgDPDCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 23:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbgDPDCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:02:02 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77232072D;
        Thu, 16 Apr 2020 03:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587006122;
        bh=2t4Q8FK2jSZL06mZSGlcjj3XmYPygHQoJwm5GyWQCHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ssu6Vz9cf844VcyhwetKFKAsXDYGb0SMV3LdkTOeji67arGy2AJa4DW1vUSZqjayC
         sIBfvY07IIm1CDZVFS5zn49poEUxUHfAnlV9lE+7mXpvYoBhPZcwgAmBw3I8FpuhwB
         pmJhc7KnDBeR8LnJObRsDxGZFeGuHVTdFvP1LVPk=
Date:   Wed, 15 Apr 2020 20:02:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, Gang He <ghe@suse.com>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aditya Pakki <pakki001@umn.edu>, ChenGang <cg.chen@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "moderated list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" 
        <ocfs2-devel@oss.oracle.com>
Subject: Re: [PATCH 3/5] ocfs2: Add missing annotation for
 dlm_empty_lockres()
Message-Id: <20200415200201.2efbbbd338a43a2f57988e2d@linux-foundation.org>
In-Reply-To: <5408edd7-87a9-ac56-5c52-c2a19c308311@linux.alibaba.com>
References: <0/5>
        <20200403160505.2832-1-jbi.octave@gmail.com>
        <20200403160505.2832-4-jbi.octave@gmail.com>
        <5408edd7-87a9-ac56-5c52-c2a19c308311@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Apr 2020 07:45:49 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> On 2020/4/4 00:05, Jules Irenge wrote:
> > Sparse reports a warning at dlm_empty_lockres()
> > 
> > warning: context imbalance in dlm_purge_lockres() - unexpected unlock
> > 
> > The root cause is the missing annotation at dlm_purge_lockres()
> > 
> > Add the missing __must_hold(&dlm->spinlock)
> > 
> Seems this is duplicate with assert_spin_locked()?

I doubt is sparse is smart enough to treat assert_spin_locked() as
equivalent to __must_hold().  It would be neat though.

