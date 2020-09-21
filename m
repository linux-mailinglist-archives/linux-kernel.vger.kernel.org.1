Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABC92727EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgIUOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbgIUOkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600699216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BLzmINm8Day3gA3zTJSbqhpotbx9mBEg33Dd5JOaGQ=;
        b=BZNdSJbmNe//b+pnYr6+eZ3KGgQwQml1heKlbg8oAscRqNxDk1739YSHFp/bp/t0B5VD9Q
        rE3pc1sUkcxiMEKE+S9ElZGhMuVImCV85U6KzgMLum8epnjTroJaUr/FiWI4Mj42nkDl3z
        8+ZnLLzUJPQA4KglFcqC++hg+nGi9j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-xHoek2jkP1yJ5s5-gFg3dQ-1; Mon, 21 Sep 2020 10:40:14 -0400
X-MC-Unique: xHoek2jkP1yJ5s5-gFg3dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81248064BA;
        Mon, 21 Sep 2020 14:40:13 +0000 (UTC)
Received: from treble (ovpn-119-131.rdu2.redhat.com [10.10.119.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C23D61177;
        Mon, 21 Sep 2020 14:40:10 +0000 (UTC)
Date:   Mon, 21 Sep 2020 09:40:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: Re: [PATCH 3/3] objtool: check: Handle calling non-function symbols
 in other sections
Message-ID: <20200921144008.n6c37mgby772bs5i@treble>
References: <20200915075318.7336-1-jthierry@redhat.com>
 <20200915075318.7336-4-jthierry@redhat.com>
 <20200918200740.3x6eookduesrgz3x@treble>
 <5afa4c67-f557-b1c4-d94c-da7610f4fcbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5afa4c67-f557-b1c4-d94c-da7610f4fcbe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:56:05AM +0100, Julien Thierry wrote:
> 
> 
> On 9/18/20 9:07 PM, Josh Poimboeuf wrote:
> > On Tue, Sep 15, 2020 at 08:53:18AM +0100, Julien Thierry wrote:
> > > Relocation for a call destination could point to a symbol that has
> > > type STT_NOTYPE.
> > 
> > Then shouldn't the callee be changed to STT_FUNC?
> > 
> 
> Not if it's a code symbol that does not follow standard calling convention.
> 
> It's really the same case as the !reloc, except this time it's in a
> different .text section.

Yeah, that makes sense.  I'll take this one as well.

-- 
Josh

