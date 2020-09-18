Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94712705F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIRUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600459668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UCjwryLhkqS1Wmq/KolRj1eRkWlSfwj0mMsHzWtCTe4=;
        b=ZHklaU08ypYvUwfYzMTmrAD3lXzM7G92SBCSwe7yMz8qyo/ilxYpioy8OrzQQNq+F1dk43
        5yHT/1tVobOz15eAVoKCb9L1WTv5qIQ1WmJgE83QI5P7bsHXjXDzdOKmJVXuBFLQS0iMG/
        6O1GwD7izSs16ztLCk8ZiCYHxwwDLik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-5mClFRb1PIaa1qlvrjrcVQ-1; Fri, 18 Sep 2020 16:07:44 -0400
X-MC-Unique: 5mClFRb1PIaa1qlvrjrcVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28AB4801AC8;
        Fri, 18 Sep 2020 20:07:43 +0000 (UTC)
Received: from treble (ovpn-112-141.rdu2.redhat.com [10.10.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD3473672;
        Fri, 18 Sep 2020 20:07:42 +0000 (UTC)
Date:   Fri, 18 Sep 2020 15:07:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: Re: [PATCH 3/3] objtool: check: Handle calling non-function symbols
 in other sections
Message-ID: <20200918200740.3x6eookduesrgz3x@treble>
References: <20200915075318.7336-1-jthierry@redhat.com>
 <20200915075318.7336-4-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915075318.7336-4-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:18AM +0100, Julien Thierry wrote:
> Relocation for a call destination could point to a symbol that has
> type STT_NOTYPE.

Then shouldn't the callee be changed to STT_FUNC?

(Apologies if we discussed this one before...)

-- 
Josh

