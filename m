Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79B9264A92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIJREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgIJREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:04:07 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C62C061757;
        Thu, 10 Sep 2020 10:04:07 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 60E78735;
        Thu, 10 Sep 2020 17:04:07 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:04:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/admin-guide: kernel-parameters:
 update CMA entries
Message-ID: <20200910110406.7db7ffe0@lwn.net>
In-Reply-To: <20200910032606.7355-2-rdunlap@infradead.org>
References: <20200910032606.7355-1-rdunlap@infradead.org>
        <20200910032606.7355-2-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Sep 2020 20:26:04 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Add qualifying build option legend [CMA] to kernel boot options
> that requirce CMA support to be enabled for them to be usable.
> 
> Also capitalize 'CMA' when it is used as an acronym.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

This doesn't apply to docs-next; it seems you're fixing 5.10 stuff in
linux-next that went through Christoph's tree?  So this patch will need to
go to him.

Thanks,

jon
