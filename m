Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB06327770F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgIXQoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:44:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:59198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgIXQoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:44:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A14022CB;
        Thu, 24 Sep 2020 16:44:02 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:43:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCH v2] docs: admin-guide: update kdump documentation due to
 change of crash URL
Message-ID: <20200924104357.7729210e@lwn.net>
In-Reply-To: <a088bff5-1174-25fa-ac26-6e46795f4085@redhat.com>
References: <20200918080958.19841-1-lijiang@redhat.com>
        <a088bff5-1174-25fa-ac26-6e46795f4085@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 09:56:02 +0800
lijiang <lijiang@redhat.com> wrote:

> Since crash utility has been moved to github, the original URL is no
> longer available. Let's update it accordingly.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

jon
