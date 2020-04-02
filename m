Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7580519CACE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbgDBUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 16:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51153 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728225AbgDBUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585858414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEVid2/hqzCwbpXVjBCKhiCXLwn+Ox5cTajgLyA7oKE=;
        b=KBXKWSqmFT5u0p+UOC0EXaFhczTIHfxouC02Zc40tmch7l1EP5rlnQo/VLu3LuQNB9/4XH
        WsahDhcmaZW9Wvs5UDGweCwIWaQpsQHoUp7bZyez4IqQzvxtw8dBm9EYJPbnIkbfOII7uQ
        TlAuJgibVWJjnuhotAyB6L5qhvILfBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-NVKHwL8nNTaO8UvSt3bvrw-1; Thu, 02 Apr 2020 16:13:33 -0400
X-MC-Unique: NVKHwL8nNTaO8UvSt3bvrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 793508017CE;
        Thu,  2 Apr 2020 20:13:31 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B8551001B09;
        Thu,  2 Apr 2020 20:13:30 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:13:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, keescook@chromium.org, x86@kernel.org,
        benh@kernel.crashing.org, dave.hansen@intel.com
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Message-ID: <20200402201328.zqnxwaetpk4ubg56@treble>
References: <20200402062401.29856-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402062401.29856-1-sblbir@amazon.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:23:58PM +1100, Balbir Singh wrote:
> Provide a mechanisn to flush the L1D cache on context switch.  The goal
> is to allow tasks that are paranoid due to the recent snoop assisted data
> sampling vulnerabilites, to flush their L1D on being switched out.

Hi Balbir,

Just curious, is it really vulnerabilities, plural?  I thought there was
only one: CVE-2020-0550 (Snoop-assisted L1 Data Sampling).

(There was a similar one without the "snoop": L1D Eviction Sampling, but
it's supposed to get fixed in microcode).

-- 
Josh

