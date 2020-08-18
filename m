Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780A1248642
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 09:41:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726727AbgHRNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597758039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXWmYAEPDvHrYOWUrEhJYqbCxad+Oxs8vtQSuseqfi8=;
        b=ijhyYXdsMM68jN67iflaxz7KkkRZHPw+5fux5on9LQYcBYK2Lj3/9WjxwbtYhOVfltTnwo
        rYWs7+StJVgtTEBYPsOHlKe621Nu/ENOk7F50JSB5RKkI0I2x1vxhg0Fcj0t5psPP4yHo+
        1lSHGpdIQwnysh81aelyIMCgD3VnCUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-VyxC6xixMB26SP9NZten_g-1; Tue, 18 Aug 2020 09:40:35 -0400
X-MC-Unique: VyxC6xixMB26SP9NZten_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EF21006701;
        Tue, 18 Aug 2020 13:40:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id E20C65C1DC;
        Tue, 18 Aug 2020 13:40:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 18 Aug 2020 15:40:33 +0200 (CEST)
Date:   Tue, 18 Aug 2020 15:40:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
Message-ID: <20200818134027.GF29865@redhat.com>
References: <20200818061239.29091-1-jannh@google.com>
 <20200818061239.29091-3-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818061239.29091-3-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18, Jann Horn wrote:
>
> +	if (dump_interrupted())
> +		return 0;
> +	n = __kernel_write(file, addr, nr, &pos);
> +	if (n != nr)
> +		return 0;
> +	file->f_pos = pos;

Just curious, can't we simply do

	__kernel_write(file, addr, nr, &file->f_pos);

and avoid "loff_t pos" ?

Oleg.

