Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DCC19C7B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgDBRMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 13:12:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731608AbgDBRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585847559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bv/mT3GmVpAqBW7CBAdxCSgNxhHVBFje5cRECjh7xXY=;
        b=Hn6YSQiSnk9eTSHvjfB63FyuZpavt4me9b1+DOXXWBTBZNtBxCCV0THEarxmwMiRlgqd/p
        6x31Z3ad7IX+kU2vfHYs/1fXEWmId2e07wScdTQ6I4D+hrxdLPFCQfOWtR3DNg8Lw4XfUW
        IDDy11uT7rhgtij3j/TU8JHLIATcMn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Vwf1N1NhN-CbsUeCeSB6Og-1; Thu, 02 Apr 2020 13:12:38 -0400
X-MC-Unique: Vwf1N1NhN-CbsUeCeSB6Og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6381E107ACC4;
        Thu,  2 Apr 2020 17:12:37 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AA521001B28;
        Thu,  2 Apr 2020 17:12:36 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:12:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 01/10] objtool: Move header sync-check ealier in build
Message-ID: <20200402171234.mbvusm7esqgydpz3@treble>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-2-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327152847.15294-2-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:28:38PM +0000, Julien Thierry wrote:
> Currently, the check of tools files against kernel equivalent is only
> done after every object file has been built. This means one might fix
> build issues against outdated headers without seeing a warning about
> this.

s/ealier/earlier/ in $SUBJECT

-- 
Josh

