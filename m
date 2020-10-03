Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2202826A0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJCUbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 16:31:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B7C0613E8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 13:31:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so6239253lfj.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9/JwcJon8kbWWL9Pv4De+Xo9KVyYTIMKvu8rVtqxlk=;
        b=SaFj8kDi0XCRV15emYTadnIY5m6Nof9mWRuVpHOOINYIs5h+sGcKJPuooElcqlleuf
         aZqAk4Z/cWlwGipdnulvCbz1eV5mha81O8o4Aqu2vji2Kj90IO3yapJZrFQcY5b00sQE
         p14NbG/fdUdwBeNgobilmBG2vYkoJWRn3l4f/R6d3vdT8WyegbaQQCG7F8/H5hROQNp7
         zABrFWl0FN9gS3AihSzKyR3s6nPOM/2wjuRatUXPPvo/Trx3XFHPh+3vaoSpDwl8QSbK
         Q/tKWhJHL8yBRF4CJwTmaH0L1ZWhP9t516FJ9F/3J/mvKHIu7SYHREGB2MiKcaExSlio
         C1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9/JwcJon8kbWWL9Pv4De+Xo9KVyYTIMKvu8rVtqxlk=;
        b=VdNsap3nbf819/0Oe6pYeFAwXUpurkhstVG4WHKZfsRPCAm60gW8Cjc5mKs4kZlQWa
         +502Jy0iv0jpT+CVS3GlfF03ifMillKscjUeeYMqwBXAlAP7F8PyIpLrRHKVevSp6eZ1
         JkQJrogDzyYn8IlEm804kgSYp669D33EsMv2al0mzett/xxDcbcLGias95LQcnH1HMhT
         Yag+NGA0egIU6japKoIIiRM+S1uLxJjnfOwlJsto2y2V/yYDh2AyfCinmgKhAYeh97fb
         RBcxrzXW3wAb9Jw19Pa8xoIEd+FdRrZDf+qms9lmQqolwR43rd1fWWCl8wgcwKud5c6b
         0DEw==
X-Gm-Message-State: AOAM533Opb+jqnqC4lLjzszY8kXq3sO7rgXaFhENQ52lNgLmHCFZ3ch7
        pdCpI4ilKPwFL5xNtF5p7IK3CA==
X-Google-Smtp-Source: ABdhPJzNjoQrrC6/r+Pg8u5bbqO7r+BkXumUZAZ3VTgnWGSxW6GnQQN/9apECIEdwkyu5/9vxJ/Xeg==
X-Received: by 2002:ac2:5e72:: with SMTP id a18mr1207157lfr.69.1601757101622;
        Sat, 03 Oct 2020 13:31:41 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x7sm1880206lfg.281.2020.10.03.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 13:31:40 -0700 (PDT)
Date:   Sat, 3 Oct 2020 12:57:27 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] ARM/arm64: dts: Fix SP804/SP805 users
Message-ID: <20201003195727.GH8203@lx2k>
References: <20200907121831.242281-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:18:25PM +0100, Andre Przywara wrote:
> Those are the remaining patches of the SP804/SP805 DT fixes. [1][2]
> ARM, Broadcom and Freescale have their respective fixes queued through
> their maintainers already, but I haven't heard back from LG or HiSilicon
> so far.
> So can those patches be taken through armsoc directly?

I've applied the ones who didn't have replies from platform maintainers yet.

Thanks!


-Olof
