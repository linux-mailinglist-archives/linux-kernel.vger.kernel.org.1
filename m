Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8842F85B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbhAOTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbhAOTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610739983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRvyAUBPTrocJOciUmV7p8wLncB1y5eW7TQ3VleD/mU=;
        b=BV06vZmzydOthf+8Y/gidS0Uc7E/mUX7/2FTu+hqFZPVP7vOlmkYfYYKEHEgDhCdwClG3H
        ri2TDvBkAY+FcM4WgD31CozeuAmiluNBoiJypWTeiOoz7GAnAf86m9JoHMFTakmfjYZS3Z
        VE+5ygSwX2lnrVUUZL0jbOd0+ETrpnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-zQbkX_wvNbynTqx47htJHA-1; Fri, 15 Jan 2021 14:46:13 -0500
X-MC-Unique: zQbkX_wvNbynTqx47htJHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329DF18C89C4;
        Fri, 15 Jan 2021 19:46:11 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C20806F7EF;
        Fri, 15 Jan 2021 19:46:08 +0000 (UTC)
Date:   Fri, 15 Jan 2021 13:46:01 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 14/21] x86/xen: Support objtool vmlinux.o validation in
 xen-head.S
Message-ID: <20210115194601.dkilnfkp6xnhai22@treble>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
 <43d47af1-6735-6651-db11-4489c86c62a2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43d47af1-6735-6651-db11-4489c86c62a2@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 06:17:25AM +0100, Jürgen Groß wrote:
> On 14.01.21 20:40, Josh Poimboeuf wrote:
> > The Xen hypercall page is filled with zeros, causing objtool to fall
> > through all the empty hypercall functions until it reaches a real
> > function, resulting in a stack state mismatch.
> > 
> > The build-time contents of the hypercall page don't matter, since it
> > gets mapped to the hypervisor.
> 
> This sentence is technically wrong: the contents don't matter, as the
> page will be rewritten by the hypervisor.

Thanks, updated for v2.

-- 
Josh

