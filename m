Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA042707DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIRVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgIRVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600463373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=asql0Sq9mQRCwtXwkfvy11Pk1zi8zsCd4+2USFTaNdY=;
        b=hLzKq7jsyFC7xVmsy1mQjsuBDyoaA2giKREpfoqTfNJHqZGjbPpyfP5LYmA5PTE2EA6U5h
        gOVr4uV5gcAoF46Legk5QdPOOLty9Z+nZuFrCv9OgHxUzSmFXiYvYRMsAuVAafJXQ7Dxn9
        e6ZSJiLbpdm2jXEiB/uv/HxeFEE3t3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-TR6Rvtz6O2ygw0S9MH7nfQ-1; Fri, 18 Sep 2020 17:09:31 -0400
X-MC-Unique: TR6Rvtz6O2ygw0S9MH7nfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865DD1009464;
        Fri, 18 Sep 2020 21:09:30 +0000 (UTC)
Received: from treble (ovpn-112-141.rdu2.redhat.com [10.10.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC025D9D5;
        Fri, 18 Sep 2020 21:09:29 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:09:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 2/3] objtool: check: Support addition to set CFA base
Message-ID: <20200918210927.eh2tilurtuhc6q4a@treble>
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-3-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915081204.9204-3-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:12:03AM +0100, Julien Thierry wrote:
> Instead of "mov SP, BP", a compiler could simply set BP
> to SP + constant. Handle changing the CFA base in such cases.

Rather than what a compiler _could_ do, it would be good to be specific
about when this can happen (presumably arm64).

-- 
Josh

