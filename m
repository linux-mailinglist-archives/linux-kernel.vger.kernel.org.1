Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FD21CB88
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgGLVMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 17:12:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729020AbgGLVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594588332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzXcGBnJoMu6yQ1ekMwxkgwaybMWLM4JDF5m7XfzkWs=;
        b=Ek0pibK7akd2VYJUKbKQpvVT3CDAjkFtvI+VRaeBwkdY4zFyBshuyZQQ1nIhWvRbOoU17/
        JSiesXDNch8QaJYYtzwdhwsEbGgxV4ftnWfG+Tz5sCvptgBbTOR/YMx+inDwhhAuGTTDb5
        vFeHyi55zYzAwLO7Cz+SEugpwRR/wwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-UftfbY3ZOO-mm81bYCRcPg-1; Sun, 12 Jul 2020 17:12:08 -0400
X-MC-Unique: UftfbY3ZOO-mm81bYCRcPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D291210059A9;
        Sun, 12 Jul 2020 21:12:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0E8CA1A836;
        Sun, 12 Jul 2020 21:12:04 +0000 (UTC)
Date:   Sun, 12 Jul 2020 23:12:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/15] perf: support enable and disable commands in
 stat and record modes
Message-ID: <20200712211204.GA156308@krava>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:36:30AM +0300, Alexey Budankov wrote:
> 
> Changes in v10:
> - reused struct priv, renamed props into flags and used unsigned int type as a storage
> - implemented and adopted usage of evlist__ctlfd_initialized() function
> - updated while condition with checking !(done || stop)
> - implemented compute_tts() to calculate the remainder of timeout to wait in poll()

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

