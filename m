Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BE1DA365
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgESVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 17:18:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbgESVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589923115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dUOct4PHoq/QWft1/j7ZZiyNUOaYPjPbdH/q9Xj/tyY=;
        b=eqUyg0FiNoJBVAFz8EZsJT176Th65GQwvVkngb6N9YjbzBJ0NOYlBIZz2O/1bNAtZN6yLn
        67dhYaIsS2poCrQ1FSxfOJeV4jkaMCCNccecUng3jhqAxFhDE7KpvWHG45BrmMpElKzC2e
        5EsMcqurWUYqrpS/2BjsNaAYM6sZlYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-7YHKrUjEN0SBEU63otyAHw-1; Tue, 19 May 2020 17:18:34 -0400
X-MC-Unique: 7YHKrUjEN0SBEU63otyAHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9202F805724;
        Tue, 19 May 2020 21:18:32 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30B4C60BE1;
        Tue, 19 May 2020 21:18:31 +0000 (UTC)
Date:   Tue, 19 May 2020 16:18:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200519211829.p2d454nz3h3mdxsa@treble>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:55:33PM -0700, Matt Helsley wrote:
> +const char __attribute__ ((weak)) *objname;
> +
> +int missing_check(const char *_objname, bool orc)
> +{
> +	return 127;
> +}
> +
> +int __attribute__ ((weak, alias("missing_check"))) check(const char *_objname, bool orc);
> +
> +int missing_orc_dump(const char *_objname)
> +{
> +	return 127;
> +}
> +
> +int __attribute__ ((weak, alias("missing_orc_dump"))) orc_dump(const char *_objname);
> +
> +int __attribute__ ((weak)) create_orc(struct objtool_file *file)
> +{
> +	return 127;
> +}
> +
> +int __attribute__ ((weak)) create_orc_sections(struct objtool_file *file)
> +{
> +	return 127;
> +}

I think the aliased "missing_" functions are no longer needed, right?
i.e. can we just have weak versions of check() and orc_dump()?

Otherwise everything looks good to me.

-- 
Josh

