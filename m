Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E821BCAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgD1SgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 14:36:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:41378 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgD1SgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:36:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D03822D6;
        Tue, 28 Apr 2020 18:36:01 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:36:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: orangefs: fix pvfs2tab literal block
Message-ID: <20200428123600.2f0f908f@lwn.net>
In-Reply-To: <20200424153515.134500-1-steve@sk2.org>
References: <20200424153515.134500-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 17:35:15 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Following a merge fix-up, the literal block is introduced too early;
> this patch merges the localhost mention with the introduction, fixing
> 
> 	Documentation/filesystems/orangefs.rst:124: WARNING: Literal block expected; none found.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied, thanks.

jon
