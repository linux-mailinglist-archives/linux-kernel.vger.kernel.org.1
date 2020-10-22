Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5501A296706
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372745AbgJVWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:11:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:48406 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509912AbgJVWLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:11:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 694F5844;
        Thu, 22 Oct 2020 22:11:31 +0000 (UTC)
Date:   Thu, 22 Oct 2020 16:11:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] docs/vm: trivial fixes to several spelling
 mistakes
Message-ID: <20201022161129.23176ae9@lwn.net>
In-Reply-To: <20201022142653.254429-1-colin.king@canonical.com>
References: <20201022142653.254429-1-colin.king@canonical.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 15:26:53 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix several spelling mistakes in vm documentation.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/vm/mmu_notifier.rst   | 2 +-
>  Documentation/vm/page_migration.rst | 2 +-
>  Documentation/vm/page_owner.rst     | 2 +-
>  Documentation/vm/slub.rst           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
