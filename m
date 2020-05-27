Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28471E4019
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgE0LcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:32:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgE0LcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590579130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3VG+r4IL3PqDE0NrR8AJTqa7Bz6Bcn6dDbe0ZST8RI=;
        b=Zdeqej5YIcLpUNlskfRACMBF4zIcuzBgzFm/o8+sFqQ1W2iIN52yznXAfhtQ+bNFVpFJrN
        sMOF1LnlWhv7s7B76mVOb3t1+gu8lbjFpf+m4X/fk5Fq232PW1NBbxZWMqXApD4a8MMY4a
        a2ngxFunoS407FRle+iLwx5as7PMiPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-JcGnGmc4PV2vYDXpIgofAA-1; Wed, 27 May 2020 07:32:06 -0400
X-MC-Unique: JcGnGmc4PV2vYDXpIgofAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA331461;
        Wed, 27 May 2020 11:32:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with SMTP id 66FED12A4D;
        Wed, 27 May 2020 11:32:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 May 2020 13:32:02 +0200 (CEST)
Date:   Wed, 27 May 2020 13:31:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 01/13] ptrace: Use regset_size() for dynamic
 regset size.
Message-ID: <20200527113158.GA9100@redhat.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
 <3700190a602a6d30fcbf76e1eea667e29a65c4c9.1590474856.git.greentime.hu@sifive.com>
 <20200526140027.GC24212@redhat.com>
 <CAHCEehK7BnWUhjOAynCLP6puRo8EguMvf=N8iG5UMQmaD8ekCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCEehK7BnWUhjOAynCLP6puRo8EguMvf=N8iG5UMQmaD8ekCQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27, Greentime Hu wrote:
>
> It seems I only needs to update this line, right?
> - kiov->iov_len = min(kiov->iov_len,  (__kernel_size_t) (regset->n *
> regset->size));
> + kiov->iov_len = min(kiov->iov_len,  (__kernel_size_t)
> regset_size(task, regset));

Yes, agreed.

Oleg.

