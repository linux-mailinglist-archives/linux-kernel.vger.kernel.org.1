Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD02E0B45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgLVOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:00:14 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34589 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbgLVOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:00:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 763D1580495
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 08:59:27 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute4.internal (MEProxy); Tue, 22 Dec 2020 08:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.at; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type:content-transfer-encoding; s=fm2; bh=tUwZF
        cl+Um4kULGzUTD+XuWX3MiivI2YAvAmiLcc7ck=; b=iMiQjRoK+k3XUFPWkDtKx
        V46JPcKeHQk6lFYCDiE3FzFEcv7hvHQ5VrmJJ7Eaolt0TxP2oY7I7/m6rDY1s2RY
        TWdXWNbGo6ozY4zFr+MjV3eHdqpgMrcLl/XvJw3kRA9HAQu4mtQae6tlqmSorJlT
        Akiq0IWlUK6w3sKKiOAzrAJUmWPxg4F+rFRlgNF5t6MqKhsRL9mgw973+P1gfVT1
        PLqJt/KnnO8nL8gXP+wL88fWlJMXOJC37ob53gAfLMHmPmYK6ajI3vqRWehXKJrT
        bwXrgFj+6Vo9MjNC5/M74iL+tDjCPR4tAoXXloryb/htDZd7LojH/QwofiDiDTFo
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=tUwZFcl+Um4kULGzUTD+XuWX3MiivI2YAvAmiLcc7
        ck=; b=OLM7+RT6LW0EJMa158yWc7Kcp3rtuzextyW9Eo+xvloPdP0Grj8VVDkg/
        JngKY52dcfMO0DBH+m1qZ61Ug2bVLxsL5HoroG9EijfMwdpHZXxyabS3DN820aCi
        tXj/fBa+ewC0Gg4G9hz6I9OlrrMEOA/WZCrme8qZqm/080yXaKc8qE7A8A6GX/pH
        d3fiyStdq+U1eGabRtoj+4ZzDztMqFcMFjcdKG/B47SWKAasTJ48z6uMXRv8tG17
        9+ReeXe0Io1H6qCHnhigSTlbxkr7QbujMC+2TplE2VzvbTBBgqWiEbwEZDaqhN6B
        kHwP55l0acSev2fOsFNxdh9RpZ7SQ==
X-ME-Sender: <xms:vvvhX51EA7_d3XsAZ7_q46xNqB0MaBnvqZt8RodBMfDPtjaxdTICNA>
    <xme:vvvhXwFhu_LurPSllSctdzN-QeJeyFcOoFEJoQ2zgWLhCK9ddz9Ju9AXsqCFt1Wc6
    Xddj1fPigof73_VEoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkgfrkfgjfhffhffvufgtgf
    esthhqredtreerjeenucfhrhhomhepvehorhhonhgruceotghovhhiugduleesshgvnhht
    rdgrtheqnecuggftrfgrthhtvghrnhepkeeufeetfefgjedtleekledvieegjeefjeduhf
    egtddtheetudehteefleeifeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheptghovhhiugduleesshgvnhhtrdgrth
X-ME-Proxy: <xmx:vvvhX56LO_WhceIDOL_yrhpATBjFu7ZICOKWf30O9_rHv8satZHfqg>
    <xmx:vvvhX23SVehZyydgK7cWLRw7KwE3xrN-N_tQtIkzHn650QPct5AfJQ>
    <xmx:vvvhX8FKWMYLele_70GtBv64l_gk4WcwbsBDMzIuCdOQgI8zCZ21DA>
    <xmx:v_vhXwTGCqHqExYqt3DSMuHC1yEei02IZDeuYZ4dCjK4muasXANalQqRN40hC9KC>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CBD362A005E; Tue, 22 Dec 2020 08:58:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
importance: high
x-priority: 1 (High)
Message-Id: <b5726162-9175-4100-abfc-42fa1b1bab3c@www.fastmail.com>
In-Reply-To: <20201221183959.1186143-1-luzmaximilian@gmail.com>
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
Date:   Tue, 22 Dec 2020 14:59:05 +0100
From:   Corona <covid19@sent.at>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Add support for Microsoft Surface System Aggressor
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21. Dez 2020 by Mr Maximilian Luz:
> Here is version three of the Surface System Aggregator Module (SAM/SSA=
M)


... Read above what I initially misread the headline for. Can=E2=80=99t =
say I=E2=80=99m a big fan of M$. Trust me on that.
