Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9252201B91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbgFSTqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:46:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:55450 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389005AbgFSTqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:46:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E79023B;
        Fri, 19 Jun 2020 19:46:34 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:46:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Fix most typos
Message-ID: <20200619134633.51e1b2ec@lwn.net>
In-Reply-To: <369b8060416ad9507ba1cd1160e20bc2f0ea7e5d.camel@perches.com>
References: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
        <20200619132045.6120f4eb@lwn.net>
        <369b8060416ad9507ba1cd1160e20bc2f0ea7e5d.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 12:37:13 -0700
Joe Perches <joe@perches.com> wrote:

> Maybe your tree should be added to -next so
> people don't have to search out specific trees.
> 
> git git://git.lwn.net/linux.git docs-next

What makes you think it's not there...?  That doesn't help much when
patches from other trees dig around in Documentation/ too.

jon
