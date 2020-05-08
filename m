Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E41CB40C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEHPxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 11:53:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588953226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2cXXVVt6hMQSGVjV4QVW4AzH91k33BUOtcXS/eKqmI=;
        b=R8SzckG059dopqH7e0D0fIpQPLfLbkTg2mpqEX8aOJjLBuqMjoJHnN/NDh8BHcA7mtCEBH
        IcBcfwOL/uas7XHqet4UbLfAp4rC3dB11o2P7h+Hu12ppnrwuBCkpV/Kxew9LlrsHjE0NI
        ikdHyyz+h5SW6PNuD70LccVvbk/2fDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-lMGPCzd4Ml65WMQz9PceyQ-1; Fri, 08 May 2020 11:53:42 -0400
X-MC-Unique: lMGPCzd4Ml65WMQz9PceyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 781C21800D42;
        Fri,  8 May 2020 15:53:41 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D52BF5D9CA;
        Fri,  8 May 2020 15:53:37 +0000 (UTC)
Date:   Fri, 8 May 2020 10:53:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Samuel Zou <zou_wei@huawei.com>
Cc:     jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] livepatch: Make klp_apply_object_relocs static
Message-ID: <20200508155335.jyfo4rhdvbyoq5kl@treble>
References: <1588939594-58255-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588939594-58255-1-git-send-email-zou_wei@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 08:06:34PM +0800, Samuel Zou wrote:
> Fix the following sparse warning:
> 
> kernel/livepatch/core.c:748:5: warning: symbol 'klp_apply_object_relocs'
> was not declared. Should it be static?

Yes, it should :-)

So instead of the question, the patch description should probably state
that it should be static because its only caller is in the file.

With that change:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

