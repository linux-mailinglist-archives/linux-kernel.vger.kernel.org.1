Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7245D2B9A88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgKSSWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgKSSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605810161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKsj/vAB3tyYOTY5WM4AqOsn+OP/VuYRxWPQE9QnHUA=;
        b=cNke37ESA/tcTjZCBAnGErBKn9ItMgSNLYwiHgi6eA5eBLjI9zQWU3wipoEcWka4jGJTJY
        oIsNlDHAv2xAOH28G+sTsOSAFU6lprzxz8dUvMZHrneShQL8Te/CjWdhTHVtJbDUtPIQIj
        rSWSPGgF460SuFUdqrra50kUgwpUI6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-UJ7j9u_7MQucV0NIpAtEiA-1; Thu, 19 Nov 2020 13:22:37 -0500
X-MC-Unique: UJ7j9u_7MQucV0NIpAtEiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C889680EFA8;
        Thu, 19 Nov 2020 18:22:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 078855D9C2;
        Thu, 19 Nov 2020 18:22:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 19 Nov 2020 19:22:29 +0100 (CET)
Date:   Thu, 19 Nov 2020 19:22:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201119182225.GB5138@redhat.com>
References: <20201119160154.GA5183@redhat.com>
 <d7c3ed05-b7e7-fac0-871f-4c43c1a7e90c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7c3ed05-b7e7-fac0-871f-4c43c1a7e90c@csgroup.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Christophe Leroy wrote:
>
>
> Le 19/11/2020 à 17:01, Oleg Nesterov a écrit :
> >Can we finally fix this problem? ;)
> >
> >My previous attempt was ignored, see
>
> That doesn't seems right.
>
> Michael made some suggestion it seems, can you respond to it ?

I did, see https://lore.kernel.org/lkml/20200611105830.GB12500@redhat.com/

> >Sorry, uncompiled/untested, I don't have a ppc machine.
>
> I compiled with ppc64_defconfig, that seems ok. Still untested.

Thanks.

Oleg.

