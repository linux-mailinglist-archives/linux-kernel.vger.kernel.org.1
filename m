Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D4C1E14EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbgEYTlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 15:41:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:33156 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbgEYTls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:41:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 79A6D4A2;
        Mon, 25 May 2020 19:41:48 +0000 (UTC)
Date:   Mon, 25 May 2020 13:41:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200525134147.7cc96e7c@lwn.net>
In-Reply-To: <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
        <20200525102825.63d72ed2@lwn.net>
        <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 20:01:45 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> > But this does not seem to do harm at this point, so I have gone ahead and
> > applied it.  
> What does this mean? Is there a kernel.org repo/branch with my patch?

That means it's in the docs-next tree.

jon
