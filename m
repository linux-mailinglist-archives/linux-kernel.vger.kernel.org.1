Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0E19D927
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391014AbgDCOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 10:32:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36904 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390812AbgDCOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:32:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id x3so8147609qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vf2o3eqZVXDAISA8ZTok99Oirgt/9Dqown4xMU1s148=;
        b=SfvPVynLH4dNuMZcXn0TAYxaLFX2sMK49SRRXlHiosykRM1hj5gp5OYmSfNq5aw3Od
         7rjOod6+IGo3ct+0TAnGt6yLDDutvsVpCIBoXouJ/e/kCAl7tk4sswfnqaPtnfQ7LWA9
         MQ2tmuokGl91Sm0XYbiSjSkMclnyJatBMHgg2KdvwRN9AEMyPNUZaGRNGMg2+zvSgNMH
         ttFv+96d8bGCFRfHeukjiPKqkNmJ9c5uaibwc0tfqa0jpjT1tF55CxGAMCil56tOA2YH
         YcjNPSMI8gP4Lwas39cDTddBcIXcYqn7POE1QIfjGz2V4MT14gDhd1sZUCoIP6ENPhz0
         FDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vf2o3eqZVXDAISA8ZTok99Oirgt/9Dqown4xMU1s148=;
        b=sVkhJsb/3qSpuSusedhmYeNnceGI3u8uHayj5TYxixTMRCaNDGnmnHEWEW8g3fZWJj
         NqaldYo8F5XvLZ0aP8k4nDEWgRJj25INtlr70nm+MCXIghRtYxR5Ujo+kqim/mF1c+Du
         0AfxTkYkGDBPPORa7I0K6pv9Dr8djFK5rQGr2CGP+47ahCgtjnkNOnz2OXNirW5KHGTe
         CC/lFprPwI3q8ffNO4UQ6wr/z4WcJxDBBCApzEVq6I2ItwdBpDGrKhi2tOw02S1+mBj6
         bnj3S82Q6AKnELWwU9yuTZmQQZ+NbvfIGLsmJ/uQiUZOknS5ihdjvpYKnGoqcJ5/cNUV
         U2dQ==
X-Gm-Message-State: AGi0PuY4QvLKcHSAztDFpG1c+4f+sI4WcwRPxdVndklJHXajJaM+4quF
        +BPRaHFmK7GZgCn5VY4/oabNVrS7vPw=
X-Google-Smtp-Source: APiQypKMIgQ2ud4+vU4utnqtMbmhq9+AjDkaofDe4BjqaPXRIe78zze/3yskU7ha/voq5+v2ZaHxpw==
X-Received: by 2002:a37:591:: with SMTP id 139mr8944797qkf.281.1585924332467;
        Fri, 03 Apr 2020 07:32:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id q1sm6023711qtn.69.2020.04.03.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:32:11 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:32:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Change kernfs_node lockdep name to "kn->active"
Message-ID: <20200403143209.GY162390@mtj.duckdns.org>
References: <20200402171056.27871-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402171056.27871-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:10:56PM -0400, Waiman Long wrote:
> The kernfs_node lockdep tracking is being done on kn->active, the
> active reference count. The other reference count (kn->count) is not
> tracked by lockdep. So change the lockdep name to reflect what it is
> tracking.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
