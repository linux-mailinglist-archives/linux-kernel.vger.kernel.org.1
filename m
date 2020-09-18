Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4F270885
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgIRVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600465673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mw/AeF/Twtz7+K8++365XUZ8mckpv04utY/MhiDyDwQ=;
        b=gyycIXWTS2NV4ywE90rLbZAREIoKxPadWl1obTtaqj+wr8cc2EnG5GGvc1cmeNV44XqavM
        z8DmInFw29bwhIWNC2fgC5Nf6diiIKvXzwES/+58bJFwyN8dRmk485cnds7Tmla5hVQSXj
        y7PzwCBbU/xeHnYRakv/9sXHQubzkVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-6W9gkoLNP6iAnBwILLVWow-1; Fri, 18 Sep 2020 17:47:49 -0400
X-MC-Unique: 6W9gkoLNP6iAnBwILLVWow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3511C1008558;
        Fri, 18 Sep 2020 21:47:48 +0000 (UTC)
Received: from treble (ovpn-112-141.rdu2.redhat.com [10.10.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 902019CBA;
        Fri, 18 Sep 2020 21:47:47 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:47:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: Re: [PATCH 0/3] objtool: Miscellaneous cleanup/fixes
Message-ID: <20200918214745.knkssfci5wi2izmj@treble>
References: <20200915075318.7336-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915075318.7336-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:15AM +0100, Julien Thierry wrote:
> Hi,
> 
> These patches provide some simple cleanup or lift small limitations
> found while working on the arm64 port.
> 
> They should apply on current tip/objtool/core branch

I've got patches 1 & 2 queued up in jpoimboe/objtool/core.

-- 
Josh

