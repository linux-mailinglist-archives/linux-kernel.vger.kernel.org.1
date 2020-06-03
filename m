Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029521EC6EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 03:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgFCBr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 21:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbgFCBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591148846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/voxD4hV8o05FUKUAITmun6VzwH7Mnxv381VjA4kiC8=;
        b=iVF1txGlTrVaYDUHF3V1PW/vd01tzAetxY9jjwEaH+HYGp8TbkLkTcNzV+3KU2NTvCxIl6
        CxfnrvNE/daj6m/gSgMsPDAE2WO3n/MIhnxk9gCxvVJpArfy+2aNzM7OiUAuYUk+eOIz7b
        TKM00SFppeNeYR/z1hDogFO2BCCNKSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Fgxkj41SPhaTgemaZM-Urg-1; Tue, 02 Jun 2020 21:47:23 -0400
X-MC-Unique: Fgxkj41SPhaTgemaZM-Urg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D75BFCB;
        Wed,  3 Jun 2020 01:47:22 +0000 (UTC)
Received: from localhost (unknown [10.10.110.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 578252C26C;
        Wed,  3 Jun 2020 01:47:21 +0000 (UTC)
Date:   Tue, 02 Jun 2020 18:47:20 -0700 (PDT)
Message-Id: <20200602.184720.772354759138688100.davem@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] a couple of sparc ptrace fixes
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200531010414.GW23230@ZenIV.linux.org.uk>
References: <20200531010414.GW23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 31 May 2020 02:04:14 +0100

> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-davem

Pulled, thanks Al.

