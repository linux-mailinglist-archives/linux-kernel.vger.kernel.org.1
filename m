Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FA2583F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 00:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHaWNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 18:13:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:39000 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHaWNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:13:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 564CF2D5;
        Mon, 31 Aug 2020 22:13:32 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:13:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2 0/2] docs/howto.rst: Sync with original
Message-ID: <20200831161331.6621a467@lwn.net>
In-Reply-To: <20200829082343.2979-1-sj38.park@gmail.com>
References: <20200829082343.2979-1-sj38.park@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 10:23:41 +0200
SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset syncs howto.rst for recent changes to the original doc and
> fix some trivial nits in the translation itself.
> 
> The patches are based on v5.9-rc2.
> 
> Changes from v1
>  - Fix mismatch between author and Signed-off-by:
> 
> SeongJae Park (2):
>   Documentation/kokr: bring process docs up to date
>   Documentation/kokr/howto: Wordsmith
> 
>  Documentation/translations/ko_KR/howto.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Set applied, thanks.

jon
