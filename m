Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E11D5896
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEOSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 14:03:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:53728 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:03:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C2276736;
        Fri, 15 May 2020 18:03:08 +0000 (UTC)
Date:   Fri, 15 May 2020 12:03:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 08/14] docs: move kobject and kref docs into the
 core-api book
Message-ID: <20200515120307.72970632@lwn.net>
In-Reply-To: <f385af13b4a6d3ff8c89beedd4506900e79ca72e.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <f385af13b4a6d3ff8c89beedd4506900e79ca72e.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:52 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Both documents are documenting Kernel core objects. So, add
> them into the core-api book.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/core-api/index.rst              | 1 +
>  Documentation/core-api/kobject.rst            | 2 +-
>  Documentation/{kref.txt => core-api/kref.rst} | 0
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  rename Documentation/{kref.txt => core-api/kref.rst} (100%)

Applied with a tweaked changelog, since it's not actually moving the
kobject doc.

jon
