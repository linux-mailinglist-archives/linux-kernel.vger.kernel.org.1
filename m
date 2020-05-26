Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABC1C5B92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgEEPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:38:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:50146 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbgEEPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:38:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C98A31A;
        Tue,  5 May 2020 15:38:06 +0000 (UTC)
Date:   Tue, 5 May 2020 09:38:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: documentation: Fix erroneous function example
 in kobject doc.
Message-ID: <20200505093804.6d39abef@lwn.net>
In-Reply-To: <20200505061828.42952-1-arch0.zheng@gmail.com>
References: <20200505061828.42952-1-arch0.zheng@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 14:18:28 +0800
Qi Zheng <arch0.zheng@gmail.com> wrote:

> Update the definitions of some functions listed in the kobject
> document, since they have been changed.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>

I've applied this since it's an improvement on the original.  The proper
fix, though, is to bring in the nice kerneldoc comments that those
functions have rather than trying to maintain another copy of that
information.

Thanks,

jon
