Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0A22EA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG0KjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 06:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgG0KjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595846343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHFJs8v+rI15sw6J/OEqL9oG0+eYh7TwaCszZjvpuHQ=;
        b=R2HhROG0DQXgV6EcTKFyE+2U0ogE+AnslLGBTejbSfdua/tinVWwkx/LEV1EQMzZ5UmRkM
        I45ww8710s9+GFdbEdWcEJU7fUzFGV9P63OUFujX1vu/edd/qGyxzsSr65jYYLeU+Nd3ai
        kI0T43yrOBL+Aq5SwZxmiFSpI+EnFtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Fyijr3LuN-mblrO0ABHLEg-1; Mon, 27 Jul 2020 06:38:59 -0400
X-MC-Unique: Fyijr3LuN-mblrO0ABHLEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A99979EC0;
        Mon, 27 Jul 2020 10:38:58 +0000 (UTC)
Received: from ovpn-114-41.ams2.redhat.com (ovpn-114-41.ams2.redhat.com [10.36.114.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4589D712D1;
        Mon, 27 Jul 2020 10:38:56 +0000 (UTC)
Message-ID: <f188e293df1271cb54c1c072aac6dbcfc232a811.camel@redhat.com>
Subject: Re: [PATCH net] mptcp: fix joined subflows with unblocking sk
From:   Paolo Abeni <pabeni@redhat.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 12:38:55 +0200
In-Reply-To: <20200727102433.3422117-1-matthieu.baerts@tessares.net>
References: <20200727102433.3422117-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 12:24 +0200, Matthieu Baerts wrote:
> Unblocking sockets used for outgoing connections were not containing
> inet info about the initial connection due to a typo there: the value of
> "err" variable is negative in the kernelspace.
> 
> This fixes the creation of additional subflows where the remote port has
> to be reused if the other host didn't announce another one. This also
> fixes inet_diag showing blank info about MPTCP sockets from unblocking
> sockets doing a connect().
> 
> Fixes: 41be81a8d3d0 ("mptcp: fix unblocking connect()")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Paolo Abeni <pabeni@redhat.com>

