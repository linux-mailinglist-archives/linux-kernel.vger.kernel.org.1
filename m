Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D016F28341E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJEKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJEKhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:37:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3488F2078E;
        Mon,  5 Oct 2020 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601894260;
        bh=YaDeC+L1wWm+9/9ZnDb7+J9I0W12Ne2LZepV/gq1oCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbKfhhD3gyQL4ivuwEZWBQDXe9KpvAPuBLH6OYOmkeOgZNmbrNLoQP7h9krjX2UHX
         0n2WkU/8lA4JZVDBoT/n6ZtXS2IzQbJ4pWtEhuolVD6S5HJeuqX9z4+Djc9ChoiYEb
         uBbRa3NmJoEACCdLRbMYZyf/MkFdkf5rqD72Eu+E=
Date:   Mon, 5 Oct 2020 12:37:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL v2] extcon next for v5.10
Message-ID: <20201005103755.GA245520@kroah.com>
References: <CGME20201005033115epcas1p212c497829985ba7f9d1e6a43bb73f74a@epcas1p2.samsung.com>
 <a9869e42-474d-a016-fa9c-c8d6d6cd3cc0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9869e42-474d-a016-fa9c-c8d6d6cd3cc0@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:44:36PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.10. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Changes from v1:
> - Fix the wrong commit id of patch.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> 
>   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.10-v2

Pulled and pushed out, thanks.

greg k-h
