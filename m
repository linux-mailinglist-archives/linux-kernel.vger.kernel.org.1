Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3382FE9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbhAUMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbhAUMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611231681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdNOWiSvpp1h1FQ1yCUgYu+uACMYKqVEBGPORZ+jdtY=;
        b=ENZwl9a9rUiP+YnNq7bBmZY/LFIX7XeFyWQ09bhL9wItUXHtzLR83RfY6EypqomYlFawxo
        glY4JSA57ancEw7ZuufcsJRy2sRlFuVKq1krd/Z2L9PiVdaTEh5QwP/dbrJhBJ6zWCkpPl
        sb15Q2B2mgmUP1nBJzjQKzB/TxUt1sY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-gVia8A6FOX638Qz587PhRw-1; Thu, 21 Jan 2021 07:21:19 -0500
X-MC-Unique: gVia8A6FOX638Qz587PhRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAD628144E0;
        Thu, 21 Jan 2021 12:21:17 +0000 (UTC)
Received: from [10.72.12.73] (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DB4060BF3;
        Thu, 21 Jan 2021 12:21:15 +0000 (UTC)
Subject: Re: [PATCH 1/2 v2] dma-iommu: use static-key to minimize the impact
 in the fast-path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-2-lijiang@redhat.com>
 <20210119152641.GA3453587@infradead.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <fcddfd41-19b5-1a56-8c64-ea9ce851030d@redhat.com>
Date:   Thu, 21 Jan 2021 20:21:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210119152641.GA3453587@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph

Thanks for the comment.
在 2021年01月19日 23:26, Christoph Hellwig 写道:
> On Tue, Jan 19, 2021 at 07:16:15PM +0800, Lianbo Jiang wrote:
>> +static DEFINE_STATIC_KEY_FALSE(__deferred_attach);
> Why the strange underscores?  Wouldn't iommu_deferred_attach_enabled

The variable is defined with the static keyword, which indicates that the
variable is only used in the local module(file), and gives a hint explicitly
with the underscore prefix. Anyway, this is my personal opinion.

> be a better name?
> 
It could be a long name?

Thanks.
Lianbo

