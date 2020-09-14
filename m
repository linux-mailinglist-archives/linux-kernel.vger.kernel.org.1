Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18DE268B92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgINM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgINMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:54:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C98C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:54:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z17so3719769pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngNWy/set35eDcRrocNaiD2hdN17P0QKd2jx49cDY3o=;
        b=EFVqJGbysM76maNrv2Noz9s4+27KusZI1iGNcHSVNLnpxGrn7ZABC7ZAScHf0wo8PG
         X4fma1wpPNK5/Sq5h7y596TswDPoXnTpknekySraTOio0HBtj54pcots2L41rFDT0Hcg
         tpNa0Ox9XHuUQXIjYbUkB2gisdNjbq4fHRUCxvDfS6OtsiV+M2ed6eWpe2ygl8nBPMjQ
         XIQrEc0bnmUkZPbxNTYvFbZPetMKPkUkYF5f2+ydYr5ED5D+QLWqgxdqMoEYIJiUqmhB
         sE4uqzfYTYFCxoClJTF+POnB0fgTnndROKLoWc7iZZhra5jDdBlq6clAK2agqnWv1HDQ
         ND2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngNWy/set35eDcRrocNaiD2hdN17P0QKd2jx49cDY3o=;
        b=oc+SJdVDuoRtAzBqjZBiaU6QVPk3JzQ3q9cZ7Zfj2cY7bAtrWoo01yu/Fkn+FRop1P
         nrkQOY458WxENq7E5+Bwa4iyfU/TNAoAxiUdhTeogBi+EgZq/Gt9rRBsCKHCEkTnOEIt
         svsIMFUnpQstRxWUA5/guDV8WYGUM7mhZJitqvBHI9kl/iiM7Sld0rDMuiOx/F2MkBOK
         GBChQr6xpVhfIqVfN+u2poiA520lvbg9MJfmlnFi+kubwVATPypBHXZoF7ZHZspXLeZ8
         5vjDdGOsMJTjtxY2sWnM9rrjUxBO8o6EtR1FJaesCsx9MaMhpsTovBkjGqFtRDAaLWxr
         6bsw==
X-Gm-Message-State: AOAM530C1zemJ40klKf11Csh/leizfP58jiHZD0LiEuKbydF+WNjbRhe
        VohME7smD686DNvKaJOecuM=
X-Google-Smtp-Source: ABdhPJxkzEsCFZ3P5WFOH11y+vjK7tvfj9W7/j1IhpCQI6TRunKvp8D1wlKDy9AGTQprD0xz7jWGVQ==
X-Received: by 2002:a17:902:c407:: with SMTP id k7mr14199547plk.95.1600088080664;
        Mon, 14 Sep 2020 05:54:40 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id w19sm10659360pfq.60.2020.09.14.05.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 05:54:39 -0700 (PDT)
Date:   Mon, 14 Sep 2020 21:54:37 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: drivers/android/binder.c:3689: Error: unrecognized
 keyword/register name `l.lwz
Message-ID: <20200914125437.GA2512402@lianli.shorne-pla.net>
References: <202009111401.bEXTltMk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009111401.bEXTltMk%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 02:37:14PM +0800, kernel test robot wrote:
> Hi Stafford,
> 
> FYI, the error/warning still remains.

A change was merged to master today that should fix this.  Please let me know if
it's still an issue.

-Stafford

