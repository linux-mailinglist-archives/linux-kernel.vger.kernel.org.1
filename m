Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63B26AFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIOVf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728039AbgIOV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600205293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phfKZE19saBhPeUBHCLwaCqp+zRaAXUigLy6+PozSog=;
        b=avIlM3yj8Qs9Lc7Qa7D+5Y4+zBiZzLNdbHRdHA864HmAzbQN1TP88DJywODgf2nXi4xWoE
        KvSqrA/1ap9E0mVIRQw6d+JrFmKjFK9YYdnMFv4F3/bnwF2Ao+OBxwJcBJEjvIS4lA1msp
        CXBNAu4G+yXt2g/GwtFLLEcY0aUmwBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2fGBfl_3PzyxUc-icf-XBw-1; Tue, 15 Sep 2020 17:28:10 -0400
X-MC-Unique: 2fGBfl_3PzyxUc-icf-XBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12CD41005E5E;
        Tue, 15 Sep 2020 21:28:08 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C9160CD0;
        Tue, 15 Sep 2020 21:28:06 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:28:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Marco Elver <elver@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915212804.vvm7ovffqynkvi5a@treble>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <CAKwvOdmNzapwEo26m0soAR2OLFxOoERPKbKgvQ0bfoqjNkEVCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmNzapwEo26m0soAR2OLFxOoERPKbKgvQ0bfoqjNkEVCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:13:01PM -0700, Nick Desaulniers wrote:
> Triple checking what I wrote above; it looks like the randconfig had
> BOTH CONFIG_KASAN=y and CONFIG_UBSAN=y enabled.  Aren't the sanitizers
> supposed to be mutually exclusive?  If so, we should ensure that via
> kconfig these can't be selected together via randconfig.

No idea...

> Another peculiarity I noticed was that it seems that enabling
> CONFIG_UBSAN_TRAP=y doesn't allow me to select
> CONFIG_UBSAN_ALIGNMENT=y.  Is that intentional? (Looks like it
> lib/Kconfig.ubsan:74).

That was done intentionally by Kees, it was putting traps in a lot of
weird places.

-- 
Josh

