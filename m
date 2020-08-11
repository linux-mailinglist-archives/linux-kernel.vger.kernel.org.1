Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3B241E37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHKQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:27:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:59252 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgHKQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:27:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 124FF31A;
        Tue, 11 Aug 2020 16:27:34 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:27:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Core-api: Documentation: Replace deprecated :c:func:
 Usage
Message-ID: <20200811102733.3c8eab83@lwn.net>
In-Reply-To: <20200810183019.22170-1-puranjay12@gmail.com>
References: <20200810183019.22170-1-puranjay12@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 00:00:19 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Replace :c:func: with func() as the previous usage is deprecated.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  Documentation/core-api/idr.rst | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Applied, thanks.

jon
