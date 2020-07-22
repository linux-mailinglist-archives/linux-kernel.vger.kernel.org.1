Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C72292E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgGVIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:01:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgGVIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595404910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGEw2+6KmINbQLaS9w07eFXaV68g44jQqk0LfmznoNQ=;
        b=UkoaCib/wKcMoGst/aG7uuMYYJjUFov684mO3o5XUcLN3SoQjgwGZK/SCIx5OWz9+98nKc
        8g0ZibHqmqU+TBQtDL8YqiAwnM7A8uUrVk5E25uj26yrjgR0A2oLk2PjlcNxGwyiZtsd3t
        Q29n5dXHOu2Jg5Hr6qrfFx4nhnRz390=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-EnNvkaRrNiOu9I10vWdqEw-1; Wed, 22 Jul 2020 04:01:49 -0400
X-MC-Unique: EnNvkaRrNiOu9I10vWdqEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EBA48018A1;
        Wed, 22 Jul 2020 08:01:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6B674F6E;
        Wed, 22 Jul 2020 08:01:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200721141516.20335-1-trix@redhat.com>
References: <20200721141516.20335-1-trix@redhat.com>
To:     trix@redhat.com
Cc:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        marcel@holtmann.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: remove redundant memsets
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <695449.1595404904.1@warthog.procyon.org.uk>
Date:   Wed, 22 Jul 2020 09:01:44 +0100
Message-ID: <695450.1595404904@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trix@redhat.com wrote:

> -	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
> -		return -EFAULT;
> -
>  	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);

Erm...  uparams is used on the very next statement after the copy_from_user().

David

