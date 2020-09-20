Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE12714D8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgITOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgITOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:09:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6D921531;
        Sun, 20 Sep 2020 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600610951;
        bh=5XwGT9TiUao6JvIAiMoHFSPdRqU5aU+lIZV71KumT/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwVbTZQFU/LjCbNmLkJSODiwcg07zf2S6gMwWsj9j5D03WilF09lefZi8TfJ5Yn1o
         EtG4kUi6H0Gs04npksBEUivtbqLfScDBjNmQmNHlyYVWh6JJwwZ+EMm85S7pAXzbzf
         sW3V2zsla4eA8wZeuY0ENuVKPNFXhroJ8s6iEWNg=
Date:   Sun, 20 Sep 2020 16:09:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/11] dt-bindings: connector: Add property to set
 initial current cap for FRS
Message-ID: <20200920140936.GC2915460@kroah.com>
References: <20200917101856.3156869-1-badhri@google.com>
 <20200917101856.3156869-5-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917101856.3156869-5-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:18:50AM -0700, Badhri Jagan Sridharan wrote:
> This change adds frs-typec-current which allows setting the initial current
> capability of the new source when vSafe5V is applied during PD3.0
> sink Fast Role Swap.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Removed the redundant usb-connector.txt that I created by mistake.
> - Moved to yaml.
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
>  include/dt-bindings/usb/pd.h                           | 10 ++++++++++
>  2 files changed, 18 insertions(+)

Don't you need to cc: the DT maintainers for new DT bindings?

thanks,

greg k-h
