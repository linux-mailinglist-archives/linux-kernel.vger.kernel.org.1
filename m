Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383B02E116F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgLWBi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbgLWBi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B67122517;
        Wed, 23 Dec 2020 01:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608687495;
        bh=cFaKE3vGIfqZ2OWUcxLmVPja2ddM4C1CVmCyiVTqL3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRAxJZkt5lq4AjMrnRgIwDi6kdHFYWc1Gw0YS1gDONE8AtAmOGYXtqe38gd5Dhyjt
         Wb6cZGLXTtkGx4zv5DSn06TC3EDULwQooVw6mLhJjFJLzHQGXDRcByy07viH9seNKL
         SzWzNXlI2pOEf4gFSs+tWykht1iSuqGt7T1j0R1E=
Date:   Tue, 22 Dec 2020 17:38:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        johannes.czekay@fau.de, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 1/2] checkpatch: kconfig: replace '---help---' with
 'help'
Message-Id: <20201222173814.f25e03a748559ec7efed9c27@linux-foundation.org>
In-Reply-To: <6f5c18acb8bac6f2d8c24e50eabc0f163c062475.camel@perches.com>
References: <eed0902b-2c5d-61fc-bb88-7edf286832c7@fau.de>
        <6f5c18acb8bac6f2d8c24e50eabc0f163c062475.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Dec 2020 11:02:15 -0800 Joe Perches <joe@perches.com> wrote:

> On Mon, 2020-12-14 at 11:23 +0100, Nicolai Fischer wrote:
> > All '---help---' lines have been replaced by just 'help'.
> > Therefore it is no longer necessary to include '---' in the regex.
> > 
> > Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> > Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
> > Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
> 
> Acked-by: Joe Perches <joe@perches.com>

Seems that [2/2] will be reissued.  Nicolai, please cc me on the v2
series?

