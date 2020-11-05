Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815352A81F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgKEPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:15:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:33920 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbgKEPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:15:28 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ABBA0750;
        Thu,  5 Nov 2020 15:15:27 +0000 (UTC)
Date:   Thu, 5 Nov 2020 08:15:26 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 56/56] scrpits: kernel-doc: validate kernel-doc
 markup with the actual names
Message-ID: <20201105081526.1f9c7f4a@lwn.net>
In-Reply-To: <20201105150017.GL17076@casper.infradead.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <a21343a7012c87391c4850bf3151ebd82add8d1c.1603469755.git.mchehab+huawei@kernel.org>
        <20201105150017.GL17076@casper.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 15:00:17 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> I wonder if we could change kernel-doc to be (optionally) less verbose.
> If we allowed people to write:
> 
> /**
>  * Add a value to a refcount.
>  * @i: The value to add to the refcount
>  * @r: The refcount
>  */
> 
> and had the kernel-doc script pick up the name of the following function
> automatically, would that be an improvement we could all agree on?

Given the number of issues Mauro just fixed where the comments had become
separated from the functions they documented, this seems potentially
hazardous...  It seems especially likely to fail with the "change foo() to
__foo() and add a new foo() down below" pattern that is fairly common.

jon
