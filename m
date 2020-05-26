Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE11BCFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD1W0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgD1W0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:26:06 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588DC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:26:05 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so247019edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5g+0q4i4NXpQKVni4wkZ3eUg4bn6IsxJhsN8wcx+ak=;
        b=WRrM+aH1PLLyNr7wFOi3+bCocCitOvbc0DiM8A52L04uR+hAWCFOQELO+cLK3d2ARe
         3fnoaqKW2ZykE2NgKVl3lLwgtBpGf/qrj0xtHF5bdG9kyFPB32X9v3qdNMSWuoDH4eAd
         P/qeU+BVQ30YADghRTV6I4/0jQ2AHy4p6xZ6OG4UmNFAMI5fsxzQASmA7052i7CKJa5G
         BQj6HQfbLpIFikiQT9JlifLO5YOTILZpQLGoWS7Sjzdz2TahCbEQM2QNeoNZvj/ot+lP
         hC6YKzmpd/k2trvrC1FyIOeiLG3HskoHMJPIUfCDKaV8xQYX01n1MGcWYRqFYJcIBTRD
         Dizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5g+0q4i4NXpQKVni4wkZ3eUg4bn6IsxJhsN8wcx+ak=;
        b=Z/ZlUjjb9gcEPndmcaULc0gdEI+T7aSvKJMd1pLdmAe0EOviDA/wa2b+NDdKsQzL4l
         x9sCQs/F/XmOxDRM5JPxNDpDQvbWjkT5peRWclzrCZ56MusCAGuVvqbkoOhj/xurVAcz
         d5XHMiv3ooSAIexIuHJUHKwfGnlToXGw2Tibmwdk197YWbDAjxpGwoTnQDWTxQ70bfV8
         wl2+KANWfGPlS8P/DegDvU4gcx5E4CptZaHdNcTXkGuS9QXglc7UlrNSUiqryvdY9JK9
         gSjZ0iqQ3NMze9RxTHi/Ivjs+tRj9Uib3oGxcJydZVmBOQhRJGpdUSw6PEJE1plLMxmi
         rx1g==
X-Gm-Message-State: AGi0Pubxn0R9D2gg4cKLG47JVJMT/2uMJ9q2PguzoUW8y5+z53Qc0Qai
        sB2LmnB6l42F+dE2jiXhWcKoZ+vjO9HCOdlcR5o0nxA=
X-Google-Smtp-Source: APiQypJdnPD8twnR2I4zFq1PmUsD3icty6Rtrg9MeAig7VH1vYYfF/k1ac08nAwqqrcf6W3VkkknzI+1g9Lre2mmLyY=
X-Received: by 2002:aa7:cd59:: with SMTP id v25mr22787222edw.135.1588112764208;
 Tue, 28 Apr 2020 15:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587500467.git.rgb@redhat.com> <b8ba40255978a73ea15e3859d5c945ecd5fede8e.1587500467.git.rgb@redhat.com>
In-Reply-To: <b8ba40255978a73ea15e3859d5c945ecd5fede8e.1587500467.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Apr 2020 18:25:53 -0400
Message-ID: <CAHC9VhR9sNB58A8uQ4FNgAXOgVJ3RaWF4y5MAo=3mcTojaym0Q@mail.gmail.com>
Subject: Re: [PATCH ghak25 v4 3/3] audit: add subj creds to NETFILTER_CFG
 record to cover async unregister
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 5:40 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Some table unregister actions seem to be initiated by the kernel to
> garbage collect unused tables that are not initiated by any userspace
> actions.  It was found to be necessary to add the subject credentials to
> cover this case to reveal the source of these actions.  A sample record:
>
>   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat family=bridge entries=0 op=unregister pid=153 uid=root auid=unset tty=(none) ses=unset subj=system_u:system_r:kernel_t:s0 comm=kworker/u4:2 exe=(null)

[I'm going to comment up here instead of in the code because it is a
bit easier for everyone to see what the actual impact might be on the
records.]

Steve wants subject info in this case, okay, but let's try to trim out
some of the fields which simply don't make sense in this record; I'm
thinking of fields that are unset/empty in the kernel case and are
duplicates of other records in the userspace/syscall case.  I think
that means we can drop "tty", "ses", "comm", and "exe" ... yes?

While "auid" is a potential target for removal based on the
dup-or-unset criteria, I think it falls under Steve's request for
subject info here, even if it is garbage in this case.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d281c18d1771..d7a45b181be0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2557,12 +2557,30 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>                        enum audit_nfcfgop op)
>  {
>         struct audit_buffer *ab;
> +       const struct cred *cred;
> +       struct tty_struct *tty;
> +       char comm[sizeof(current->comm)];
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_NETFILTER_CFG);
>         if (!ab)
>                 return;
>         audit_log_format(ab, "table=%s family=%u entries=%u op=%s",
>                          name, af, nentries, audit_nfcfgs[op].s);
> +
> +       cred = current_cred();
> +       tty = audit_get_tty();
> +       audit_log_format(ab, " pid=%u uid=%u auid=%u tty=%s ses=%u",
> +                        task_pid_nr(current),
> +                        from_kuid(&init_user_ns, cred->uid),
> +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +                        tty ? tty_name(tty) : "(none)",
> +                        audit_get_sessionid(current));
> +       audit_put_tty(tty);
> +       audit_log_task_context(ab); /* subj= */
> +       audit_log_format(ab, " comm=");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_d_path_exe(ab, current->mm); /* exe= */
> +
>         audit_log_end(ab);
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);

-- 
paul moore
www.paul-moore.com
